<!doctype html>
<html lang="ja">
  <head>
    <title>builderscon - {% if title %}{{ title }}{% else %}Discover Something New{% endif %}</title>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="@builderscon" name="twitter:site"/>
    <link href="{{ url('statics', filename='images/favicon.ico') }}" rel="shortcut icon"/>
    <link href="{{ url('statics', filename='css/style.css') }}" rel="stylesheet"/>
{% block header %}{% endblock %}
  </head>
  <body{% if body_id %} id="{{ body_id }}"{% endif %}>
    <div id="wrapper">
      <header id="header">
        <div class="inner">
          <h1>
            <a href="/"><img alt="builderscon" src="{{ url('statics', filename='images/logo.png') }}"/></a>
          </h1>
        </div>
        <nav id="menu">
          <div id="gnavi">
            <ul class="menu">
              {% block menuitems %}{% endblock %}
              {% if not login %}
              <li><a href="login">LOGIN</a></li>
              {% else %}
              <li><a href="logout">{{ login.username }}</a></li>
              {% endif %}
            </ul>
          </div>
        </nav>
      </header>
{% block heroimage %}
      <div id="heroimage">
        <div class="wrapper">
          <div class="inner">
            <div class="column">
              {% block herotext %}
              {% endblock %}
            </div>
          </div>
        </div>
      </div>
{% endblock %}
      <div id="contents" class="index">
        {% block main %}
        {% endblock%}
      </div>
      <div id="pagetop" style="display: block;">
        <a href="#top" style="opacity: 1;"><span class="i-flight"></span></a>
      </div>
      <aside>
        <div id="footer-logo">builderscon</div>
      </aside>
      <footer id="footer">
        <div class="inner">
          <div class="contents">
            <p>builderscon is a festival for the technology lovers.</p>
            <address>&copy; 2016 builderscon</address>
          </div>
        </div>
      </footer>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.3/jquery.min.js"></script>
    <script src="{{ url('statics', filename='js/functions.js') }}"></script>
    <script src="{{ url('statics', filename='js/jquery.cookie.js') }}"></script>
    <script src="{{ url('statics', filename='js/jquery.easing.1.3.js') }}"></script>
    <script src="{{ url('statics', filename='js/jquery.rotate.js') }}"></script>
    {% block scripts %}{% endblock %}
  </body>
</html>
