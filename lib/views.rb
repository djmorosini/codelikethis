# methods for rendering components that are shared across many pages or widgets
# class Something < Erector::Widget
#   include Views
#   ...

module Views

  def centered_codelikethis_logo
    center class: 'logo ml-auto mr-auto' do
      img.logo(src: '/images/logo.png',
               alt: "Code like this!")
      br
      text "by Burlington Code Academy"
    end
  end

  def twitter
    div.twitter do
      # https://twitter.com/settings/widgets
      # https://dev.twitter.com/docs/embedded-timelines
      rawtext <<-HTML
<a class="twitter-timeline" width="340" height="500" href="https://twitter.com/codelikethis" data-widget-id="294871116827197443">Tweets by @codelikethis</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
      HTML
    end
  end

  def markdown text
    @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                           :tables => true,
                                           :fenced_code_blocks => true,
                                           :no_intra_emphasis => true,
                                           :autolink => true,
                                           :strikethrough => true,
                                           :lax_html_blocks => false,
                                           :space_after_headers => true,
                                           :superscript => false
    )

    text raw(@@markdown.render(text))
  end

  def with_tooltip(tooltip_text)
    # https://getbootstrap.com/docs/4.0/components/tooltips/
    tooltip_options = {
      title: tooltip_text,
      'data-html': true,
      'data-toggle': "tooltip",
      'data-placement': "right",
    }
  end

end
