<p align="center">
  <img src="https://gl.githack.com/{{ namespace }}/{{ project }}/raw/master/logo.png">
</p>

<h1 align="center">{{ title }}</h1>

<p align="center">{{ subtitle }}</p>

<p align="center">
  <a href="https://gitlab.com/{{ namespace }}/{{ project }}/commits/master">
    <img alt="pipeline status" src="https://gitlab.com/{{ namespace }}/{{ project }}/badges/master/pipeline.svg" />
  </a>
  <!--<a href="https://gitlab.com/{{ namespace }}/{{ project }}/commits/master">
    <img alt="coverage report" src="https://gitlab.com/{{ namespace }}/{{ project }}/badges/master/coverage.svg" />
  </a>-->
  <a href="https://gitter.im/{{ namespace }}/{{ project }}">
    <img alt="gitter chat" src="https://badges.gitter.im/{{ namespace }}/{{ project }}.svg" />
  </a>
</p>

{% for section in readme_sections %}
  {% include "readme_" + section + ".md" with context %}

{% endfor %}
