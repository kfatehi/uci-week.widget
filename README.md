# important

you need a `uci-widget-config.json` file in your home directory -- see the example below

the todo integration is optional, if you don't care for it, do not define a `todoFile`

# example config

```
{
    "todoFile": "~/todo.txat",
    "courses": [
        {
            "name": "INF 125: Game Programming",
            "www": "http://ics.uci.edu/~ddenenbe/113-125/",
            "gdrive": "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwamoydkEzcXNzQWs",
            "discord": "https://discordapp.com/channels/228686226436128778/228686226436128778",
            "github": "https://bitbucket.org/convolutedconcepts/",
            "dir": "/Users/keyvan/Dropbox/UCI/Fall-2016/INF-125",
            "todoFilter": "^125"
        },
        {
            "name": "INF 133: User Interaction Software",
            "canvas": "https://canvas.eee.uci.edu/courses/2751",
            "www": "https://eee.uci.edu/16f/37070/",
            "dir": "/Users/keyvan/Dropbox/UCI/Fall-2016/INF-133",
            "todoFilter": "^133"
        },
        {
            "name": "INF 161: Social Analysis of Computerization",
            "www": "https://eee.uci.edu/16f/37090/",
            "gdrive": "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwYnhrUEZOUG1pVnM",
            "dir": "/Users/keyvan/Dropbox/UCI/Fall-2016/INF-161",
            "todoFilter": "^161"
        },
        {
            "name": "INF 191: Project Course",
            "canvas": "https://canvas.eee.uci.edu/courses/2966",
            "groupme": "https://web.groupme.com/chats",
            "slack": "https://tableauautomation.slack.com/messages/@slackbot/",
            "gdrive": "https://drive.google.com/drive/u/1/folders/0B-TeA-VgdXKwVkRVZlRvRkxFZWc",
            "asana": "https://app.asana.com/0/190576529875988/list",
            "instagantt": "https://instagantt.com/app/#",
            "when2meet": "http://www.when2meet.com/?5645971-37uAg",
            "tableau": "http://tableau.ics.uci.edu/",
            "github": "https://github.com/bdwalker93/TMU",
            "dir": "/Users/keyvan/Dropbox/UCI/Fall-2016/INF-191",
            "todoFilter": "^191"
        },
        {
            "name": "UNI AFF 1A: Living 101",
            "www": "https://eee.uci.edu/16f/86058",
            "dir": "/Users/keyvan/Dropbox/UCI/Fall-2016/L101",
            "todoFilter": "^L101"
        },
        {
            "name": "Self",
            "dir": "/Users/keyvan/Dropbox/SelfLearn",
            "todoFilter": "self"
        }
    ]
}
```
