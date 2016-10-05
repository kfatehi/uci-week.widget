courses: [
    name: "INF 125: Game Programming"
    www: "http://ics.uci.edu/~ddenenbe/113-125/"
    gdrive: "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwamoydkEzcXNzQWs"
    discord: "https://discordapp.com/channels/228686226436128778/228686226436128778"
  ,
    name: "INF 133: User Interaction Software"
    canvas: "https://canvas.eee.uci.edu/courses/2751"
    www: "https://eee.uci.edu/16f/37070/"
  ,
    name: "INF 161: Social Analysis of Computerization"
    www: "https://eee.uci.edu/16f/37090/"
    gdrive: "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwYnhrUEZOUG1pVnM"
  ,
    name: "INF 191: Project Course"
    canvas: "https://canvas.eee.uci.edu/courses/2966"
    groupme: "https://web.groupme.com/chats"
    slack: "https://tableauautomation.slack.com/messages/@slackbot/"
    gdrive: "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwVkRVZlRvRkxFZWc"
    asana: "https://app.asana.com/0/190576529875988/list"
    instagantt: "https://instagantt.com/app/#"
    when2meet: "http://www.when2meet.com/?5645971-37uAg"
    tableau: "http://tableau.ics.uci.edu/"
    github: "https://github.com/bdwalker93/TMU"
  ,
    name: "UNI AFF 1A: Living 101",
    www: "https://eee.uci.edu/16f/86058"
]
command: "echo $(date +'%V')"
refreshFrequency: 86400 * 1000 # 24 hours
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
  url = c[key]
  if (url)
    """<a href="#{url}">#{@img(key)}</a>"""
  else
    ""
renderIcons: (gen) ->
  out = ""
  for key,v of @iconMap
    out += gen(key)
  out
renderRows: ->
  out = ""
  for key of @courses
    c = @courses[key]
    r = @resource(c)
    if c.url
      label = """<a href="#{c.url}">#{c.name}</a>"""
    else
      label = c.name
    out+="""
      <tr>
        <td style="padding-top:20px">
          #{label}
          #{@renderIcons(r)}
        </td>
      </tr>
    """
  out
render: (wk) -> """
  <h1>Week #{wk} of 52</h1>
  <h2>#{@weekString(wk)}</h2>
  <table>
    <tbody>
      <tr>
        <td class="eee" colspan=2>
          <a href="https://www.reg.uci.edu/calendars/quarterly/2016-2017/quarterly16-17.html">Calendar</a> |
          <a href="https://eee.uci.edu/myeee/">EEE</a> |
          <a href="https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwT2dfQk5rbjVpSlU">
            #{@img('gdrive')}
          </a>
        </td>
      </tr>
      #{@renderRows()}
    </tbody>
  </table>
  """
style: """
  background: white no-repeat 50% 20px
  box-sizing: border-box
  color: #141f33
  font-family: Helvetica Neue
  font-weight: 300
  left: 0%
  line-height: 1.5
  padding: 20px
  top: 10%

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

  .eee
    border-bottom: 1px solid #ccc;
"""
