{% set left = 3 %}
{% set right = 12 - left %}
  <div class="section article">
    <div class="inner">
      <h1 class="section-header">{% trans %}Submission Form{% endtrans %}</h1>
      <div class="section-content">
        <form class="cfp-form" action="{{ action }}" method="post">
{% set termsOfUseURL = 'https://docs.google.com/document/d/1dX6RaYwjZ4VF31_UgrFgQYlkH1ayH39kEG0T3lCPOxo/edit?usp=sharing' %}
{% if for_edit %}
          <input type="hidden" name="id" value="{{ session.id }}">
{% endif %}
          <div class="row">
            <div class="large-12 columns"><h3>{% trans %}Proposal Details{% endtrans %}</h3></div>
          </div>
            <div class="tabs cfptabs" data-tabs id="cfptabs">
{% for l in languages %}
              <div class="tabs-title cfptabs-title{% if loop.first %} is-active{% endif %}">
                <a href="#panel-{{languages[loop.index0].value}}" {% if loop.first %}aria-selected="true"{% endif %} class="cfptabs-title-inside">{{ _(l.name) }}</a>
              </div>
{% endfor %}
            </div>
            <div class="tabs-content cfptabs-content" data-tabs-content="cfptabs">
{% for l in languages %}
            <div id="panel-{{languages[loop.index0 ].value}}" class="tabs-panel cfptabs-panel{% if loop.first %} is-active{% endif %}">
            <div class="row">
              <p class="notice-small">{% trans %}You must provide at least one title and abstract in any of the supported languages{% endtrans %}</p>
              <div class="large-{{ left }} columns">
                <label>{% trans %}Title{% endtrans %}</label>
                {% if errors and missing.get('title') %}<span class="error">{% trans %}required field{% endtrans %}</span>{% endif %}
              </div>
              <div class="large-{{ right }} columns">
                <div class="row" style="margin-left: 0em">
                  <div class="large-11 columns">
{% set itemName = 'title#' + l.value if l.value != 'en' else 'title' %}
                    <input type="text" class="title-input" name="{{ itemName }}"{% if session %} value="{{ session.get(itemName, '') }}"{% endif %} placeholder="{% trans lang=_(l.name) %}Please provide the session title in {{ lang }}{% endtrans %}"/>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="large-{{ left }} columns">
                <label>{% trans %}Abstract{% endtrans %}</label>
                {% if errors and missing.get('abstract') %}<span class="error">{% trans %}required field{% endtrans %}</span>{% endif %}
              </div>
              <div class="large-{{ right }} columns">
                <div class="row" style="margin-left: 0em">
                  <div class="large-11 columns">
{% set itemName = 'abstract#' + l.value if l.value != 'en' else 'abstract' %}
                    <textarea class="abstract-textarea" name="{{ itemName }}" rows="8" placeholder="{% trans lang=_(l.name) %}Please provide the session abstract in {{ lang }}
You may use Markdown in this field{% endtrans %}">{% if session %}{{ session.get(itemName, '') }}{% endif %}</textarea>
                  </div>
                </div>
              </div>
            </div>
          </div>
{% endfor %}
          </div>
          <div class="row">
            <div class="large-{{ left }} columns">
              <label>{% trans %}Session Type{% endtrans %}</label>
              {% if errors and missing.get('session_type_id') %}<span class="error">{% trans %}required field{% endtrans %}</span>{% endif %}
            </div>
            <div class="large-{{ right }} columns">
              <select name="session_type_id">
                {% for stype in session_types %}
                <option value="{{ stype.id }}"{% if selected_session_type_id == stype.id %} selected="selected"{% endif %}{% if not user.is_admin and not stype.is_accepting_submission %}disabled="disabled"{% endif %}>{{ _(stype.name) }}{% if not stype.is_accepting_submission %} [{% trans %}SUBMISSION CURRENTLY CLOSED{% endtrans %}]{% endif %}</option>
                {% endfor %}
              </select>
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Material Level{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <select name="material_level" id="select-material-level">
{% set levels = [
  { 'name': _('Beginner'), 'value': 'beginner' },
  { 'name': _('Intermediate'), 'value': 'intermediate' },
  { 'name': _('Expert'), 'value': 'advanced' }
] %}
{% for level in levels %}
                <option value="{{ level.value }}" id="{{ level.value }}"/><label for="{{ level.value }}">{{ _(level.name) }}</option>
{% endfor %}
              </select>
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Spoken Language{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <p class="notice-small">{% trans %}Please select which language you will be speaking in.{% endtrans %}</p>
              <select name="spoken_language" id="select-spoken-language">
{% set sel_spoken_language = session.get('spoken_language', 'en') if session else 'en' %}
{% for l in languages %}
                <option value="{{ l.value }}"{% if l.value == sel_spoken_language %} selected="selected"{% endif %}><label for="{{ l.value }}">{{ _(l.name) }}</label></option>
{% endfor %}
              </select>
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Slide Language{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <p class="notice-small">{% trans %}Please select which language you will write your slides in.{% endtrans %}</p>
            <p>{{ sel_slide_language }}</p>
              <select name="slide_language" id="select-slide-language">
{% for l in languages %}
                <option value="{{ l.value }}"><label for="{{ l.value }}">{{ _(l.name) }}</label></option>
{% endfor %}
              </select>
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Comments{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <textarea name="memo" rows=4 placeholder="{% trans %}Specify any communication that you might want to relay to the organizer: e.g. special financial requirements, required documents, specific dates during the conference you might not be able to attend, etc{% endtrans %}">{% if session %}{{ session.get('memo', '') }}{% endif %}</textarea>

            </div>
          </div>
          <div class="row">
            <div class="large-12 columns">
              <h3>{% trans %}Videos, Photos, and Materials{% endtrans %}</h3>
              <p class="notice-small">{% trans %}Please refer to our <a href="{{termsOfUseURL}}" target="_blank">terms of use</a> about how builderscon uses videos, photos, and other materials.{% endtrans %}</p>
            </div>
          </div>
{% if slide_url %}
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Slide URL{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <input type="text" name="slide_url" placeholder="{% trans %}Please provide the URL of where you uploaded your slide{% endtrans %}"{% if session %} value="{{ session.slide_url }}"{% endif %}>
            </div>
          </div>
{% endif %}
{% if video_url %}
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Video URL{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <input type="text" name="video_url"{% if session %} value="{{ session.video_url }}"{% endif %}>
            </div>
          </div>
{% endif %}
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Photo Release{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <p>{% trans %}By selecting "Allow" below, you agree to allow builderscon to take your photo during the duration of the event, and to distribute and place those photos on our website(s).{% endtrans %}</p>
{% set sel_photo_release = session.get('photo_release', 'allow') if session else 'allow' %}
{% set photo_release_choices = [
    {'name': _('Allow'), 'value': 'allow' },
    {'name': _('Disallow'), 'value': 'disallow' }
] %}
{% for choice in photo_release_choices %}
              <input type="radio" name="photo_release" value="{{ choice.value }}"{% if sel_photo_release == choice.value %} checked="checked"{% endif %}/><span class="yes-no">{{ _(choice.name) }}</span>
{% endfor %}
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Recording Release{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <p>{% trans %}By selecting "Allow" below, you agree to allow builderscon to record your presentation on video, and to distribute and place those recordings on our website(s).{% endtrans %}</p>
{% set sel_recording_release = session.get('recording_release', 'allow') if session else 'allow' %}
{% set recording_release_choices = [
    {'name': _('Allow'), 'value': 'allow' },
    {'name': _('Disallow'), 'value': 'disallow' }
] %}
{% for choice in recording_release_choices %}
              <input type="radio" name="recording_release" value="{{ choice.value }}"{% if sel_recording_release == choice.value %} checked="checked"{% endif %}/><span class="yes-no">{{ _(choice.name) }}</span>
{% endfor %}
            </div>
          </div>
          <div class="row">
            <div class="large-{{ left }} columns"><label>{% trans %}Materials Release{% endtrans %}</label></div>
            <div class="large-{{ right }} columns">
              <p>{% trans %}By selecting "Allow" below, you agree to allow builderscon to distribute and place materials from your presentation (such as slides) on our website(s), including from our API.{% endtrans %}</p>
{% set sel_material_release = session.get('materials_release', 'allow') if session else 'allow' %}
{% set material_release_choices = [
    {'name': _('Allow'), 'value': 'allow' },
    {'name': _('Disallow'), 'value': 'disallow' }
] %}
{% for choice in material_release_choices %}
              <input type="radio" name="materials_release" value="{{ choice.value }}"{% if sel_material_release == choice.value %} checked="checked"{% endif %}/><span class="yes-no">{{ _(choice.name) }}</span>
{% endfor %}
            </div>
          </div>
{% if not for_edit %}
          <div class="row tos-agreement">
            <div class="large-12 columns">
              <div>{% trans %}I hereby confirm that I am submitting this proposal after reading the terms of use, and that I understand and agree to its contents.{% endtrans %}</div>
              <div><span class="i-documents"></span><a href="{{termsOfUseURL}}" target="_blank">{% trans %}Terms Of Use{% endtrans %}</a></div>
              <div><input type="checkbox" name="terms_of_use" value=true id="terms_of_use_yes" /> <span class="yes-no">{% trans %}Yes, I agree to the Terms Of Use{% endtrans %}</span></div>
            </div>
          </div>
{% endif %}
          <div class="row">
            <div class="large-12 columns">
              <button id="submit-button" type="submit" class="expanded button{% if not for_edit %} disabled{% endif %}"{% if not for_edit %} disabled="disabled"{% endif %}>{% trans %}Submit your proposal{% endtrans %}</button>
{% if not for_edit %}
              <p class="notice-small">{% trans %}Please check agree to our Terms Of Use before submitting your proposal.{% endtrans %}</p>
{% endif %}
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>


