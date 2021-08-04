def header(font_awesome_kit_id):
    s = """<!DOCTYPE html>
    <html>

    <head>
        <title>Agenda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="refresh" content="1800">
        <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="https://kit.fontawesome.com/{}.js" crossorigin="anonymous"></script>
    </head>
    """.format(font_awesome_kit_id)

    return s


def weather(weather_entry):
    i = weather_entry

    temperature = i['temperature']
    if temperature:
        temperature = '{} °C'.format(str(temperature))
    else:
        temperature = ''

    s = """
        <div class="contact-item">
        <b class="weather">{}:</b> <i class="fas fa-{}"></i>{}<br>
        {}
    </div>
    """.format(i['title'], i['icon'], temperature, i['summary'])

    return s

def header_extend():
    s = """

    <style>
        html {
            width: 100%;
            font-size: 18px;
        }

        ul {
            padding-left: 1.2em;
        }

        b {
            padding-right: 1.2em;
        }

        .weather {
            padding-right: 0.5em;
        }

        #name-wrapper {
        padding-top: 1rem;
        padding-bottom: 1rem;
    }

    #fullname {
        font-size: 2.2rem;
    }

    #jobtitle {
        font-size: 1.2rem;
        margin-top: .8rem;
    }

        body {
            text-align: center;
            width: 100%;
            font-family: "Noto Sans", "Segoe UI", Roboto, Helvetica, "Hiragino Sans GB", "Microsoft Yahei", sans-serif;
            -webkit-font-smoothing: antialiased;
            font-size: 1rem;
            margin: 0;
            margin-left:30px;
            color: #282c34;
            background-color: #fbfbfb;
        }


        .container {
            max-width: 48rem;
            margin-left: auto;
            margin-right: auto;
            text-align: left;
            margin-bottom: 1rem;
        }

        .fas {
            padding-right: 0.5em;
        }

        header {
            display: flex;
            justify-content: space-between;
            border-bottom: .1rem solid #bbbbbb;
            padding-top: 2.2rem;
            padding-bottom: 2.2rem;
        }

        section {
            display: flex;
            padding-top: 2.4rem;
            padding-bottom: 2.4rem;
            padding-left: .2rem;
            /* border-bottom: .1rem solid #bbbbbb; */
            hyphens: auto;
        }

        .section-title {
            font-size: 1.6rem;
            text-align: left;
            min-width: 10rem;
        }

        .section-content {}

        .section-flex {
            display: flex;
            flex-wrap: wrap;
        }

        .block {
            margin-bottom: 2rem;
        }

        .block-square {
            width: 18rem;
        }

        .block-square:nth-last-child(2) {
            margin-bottom: 0;
        }

        .block:last-child {
            margin-bottom: 0;
        }

        .block-title {
            font-size: 1.2rem;
            margin-bottom: .4rem;
            /* font-weight: bold; */
        }

        .block-subtitle {
            font-size: 1rem;
            margin-bottom: 1rem;
            color: #bbbbbb;
        }

        .block-content {
            font-size: 1rem;
            line-height: 1.5;
        }

        footer {
            color: #bbbbbb;
            font-size: 1rem;
            min-height: 3rem;
            line-height: 3rem;
            margin-top: 1rem;
            margin-bottom: 1rem;
        }

        @media print {
            html {
                font-size: 12px;
            }

            .print {
                display: none;
            }
        }

        @media screen and (max-width: 48rem) {
            html {
                font-size: 12px;
            }

            .container {
                padding-left: .4rem;
                padding-right: .4rem;
            }

            header {
                display: block;
                padding-bottom: 1rem;
            }

            #name-wrapper {
                text-align: center;
                padding-bottom: 2rem;
            }

            #contact {
                padding-top: 1rem;
                border-top: .1rem solid #bbbbbb;
            }

            .contact-item {
                padding-top: .2rem;
                padding-left: .4rem;
            }

            section {
                display: block;
                padding-top: 2rem;
                padding-bottom: 2rem;
            }

            .section-title {
                text-align: center;
                margin-bottom: 2rem;
            }

            .section-flex {
                display: block;
            }

            .block-square {}

            .block-square:nth-last-child(2) {
                margin-bottom: 2rem;
            }
        }
    </style>


    <body>
        <div class="container">

                <header>
                    <div id="name-wrapper">
                        <div id="fullname">
                            Agenda
                        </div>
                        <div id="jobtitle">
                        """

    return s

def header_today():
    from datetime import datetime
    current_date = datetime.now().date()
    display_date = current_date.strftime('%b %d, %Y')

    s = """
                            <b>Today</b> {}
                        </div>
                    </div>

    """.format(display_date)

    return s


def section_day(day_name):
    s = """
            <section id="day">
            <div class="section-title">
                {}
            </div>
""".format(day_name)

    return s


def event(start, end, summary, next_event_in):
    s = f"""
                <div class="block">
                    <div class="block-title">
                        <b>{start} - {end} </b> {summary}
            """

    if next_event_in:
        s += f"""
                <br>
                <br>
                <center>next event in {next_event_in} hours</center>
            """

    s += """
                    </div>
                </div>
    """

    return s
