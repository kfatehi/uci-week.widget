# you can debug at http://localhost:41416/
configFilePath: '~/uci-widget-config.json'
command: "echo $(date +'%V')"
refreshFrequency: 30 * 60 * 1000
weekSliceMap:
  spring: 12
  fall: 38
session: (wk, numWeeks) -> (name) =>
  sliceAt = @weekSliceMap[name]
  weekNo = parseInt(wk) - sliceAt
  if weekNo <= numWeeks && weekNo >= 0
    "UCI Week #{weekNo} of 10"
weekString: (wk) ->
  q = @session(wk, 10)
  q('spring') || q('fall') || ''
iconMap:
  dir: 'dir.png'
  canvas: 'canvas.ico'
  www: 'www.svg'
  gdrive: 'gdrive.png'
  groupme: 'groupme.jpg'
  slack: 'slack.jpg'
  instagantt: 'instagantt.png'
  asana: 'asana.jpg'
  tableau: 'tableau.ico'
  when2meet: 'clock.png'
  discord: "discord.png"
  github: "github.ico"
img: (key) -> """
  <img src="uci-week.widget/img/#{@iconMap[key]}" />
  """
resource: (c) -> (key) =>
  val = c[key]
  if (val)
    """<a class="resource" href="#{val}">#{@img(key)}</a>"""
  else
    ""
renderIcons: (gen) ->
  out = ""
  for key,v of @iconMap
    out += gen(key)
  out

renderRows: (domEl, courses) ->
  today = new Date().getDay()
  isToday = (daysArray) ->
    if daysArray?
      daysArray.indexOf(today) >= 0

  container = $(domEl).find('tbody')
  for key of courses
    c = courses[key]
    r = @resource(c)
    container.append $("""
      <tr>
        <td>
          <span class="#{if isToday(c.days) then 'today' else ''}">#{c.name}</span>
          <div class="icons">#{@renderIcons(r)}</div>
          <ul class="todo"></ul>
        </td>
      </tr>
    """)

renderError: (domEl, err) ->
  msg = if err.message then err.message else err
  $(domEl).find('#errors').append $('<div>').append(msg)

render: (wk) -> """
  <div id="errors"></div>
  <table>
    <tbody>
      <tr>
        <td class="toplinks" colspan=2>
          #{@weekString(wk)} |
          <a href="https://www.reg.uci.edu/calendars/quarterly/2016-2017/quarterly16-17.html">Calendar</a> |
          <a href="https://eee.uci.edu/myeee/">EEE</a> |
        </td>
      </tr>
    </tbody>
  </table>
  """

setupDirLinks: (el) ->
  run = (c)=>()=> @run c ; false
  for a,i in $(el).find('a.resource')
    val = $(a).attr('href')
    if /^\//.test(val)
      $(a).on 'click', run("open #{val}")

fillTodo: (el, courses, todoFile) ->
  markAsDone = (lineIndex, el) =>
    @run "uci-week.widget/todo-mark-done.sh #{lineIndex+1} #{todoFile}", (err, res) ->
      el.remove()
  createItems = (all) => (filter) => (ul) =>
    pattern = new RegExp(filter)
    indexify = (text, i) -> ({ text: text, index: i })
    select = (i) -> pattern.test(i.text)
    $(ul).append all.map(indexify).filter(select).map (i) ->
      text = i.text.replace(pattern,'')
      todoEl = $("<li>")
      done = $('<button>x</button>').on 'click', ->
        markAsDone(i.index, todoEl)
      todoEl.append(done)
      todoEl.append(text)

  @run "cat #{todoFile}", (err, out) =>
    if err
      @renderError(el, err)
    else
      all = out.trim().split("\n")
      populate = createItems(all)

      for ul,i in $(el).find('ul.todo')
        course = courses[i]
        populate(course.todoFilter)(ul)

getConfig: (configFile, cb) ->
  @run "cat #{configFile}", (err, res) =>
    if err
      cb(err)
    else
      try
        cb(null, JSON.parse(res))
      catch terr
        cb(terr)

afterRender: (el) ->
  @getConfig @configFilePath, (err, config) =>
    if err
      @renderError(el, "Failed to load config file #{@configFilePath}")
      @renderError(el, err)
    else
      @renderRows(el, config.courses)
      @setupDirLinks(el)
      if config.todoFile
        @fillTodo(el, config.courses, config.todoFile)

style: """
  background: white no-repeat 50% 20px
  box-sizing: border-box
  color: #141f33
  font-family: Helvetica Neue
  font-weight: 300
  top: 8%
  left: 0%
  padding: 20px

  .today
    font-weight: bold

  #errors
    color: red

  a
    text-decoration: none

  h1
    font-size: 20px
    font-weight: 300
    margin: 16px 0 8px

  h2
    font-size: 16px
    font-weight: 200
    margin: 16px 0 8px

  .toplinks
    border-bottom: 1px solid #ccc;

  td
    max-width: 400px
"""


