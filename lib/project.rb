require 'erector'
require 'thing'
require 'views'

class Project < Thing
  def self.projects_dir
    @@projects_dir ||= begin
      app_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
      File.join(app_dir, "public", "projects")
    end
  end

  def self.all
    # for now, just get all projects ever
    pattern = '*.md'
    Dir[File.join(File.absolute_path(projects_dir), pattern)].sort.map do |file|
      file.slice! /^#{projects_dir}\//
      file.slice! /\.md$/
      Project.new(name: file)
    end
  end

  # is this project optional? default: false
  attr_reader :optional
  # where the project is located; nil means it's in here
  attr_reader :from

  def projects_dir
    @projects_dir || Project.projects_dir
  end

  def content_file
    File.new(File.join(projects_dir, "#{@name}.md"))
  end

  # todo: use OO, not switch statement, for 'From' href and icon

  def href
    case from
    when nil
      @href || "/projects/#{name}"
    when 'fcc'
      # TODO: fix FreeCodeCamp itself to allow links to challenges/lessons
      "https://beta.freecodecamp.org/en/challenges/basic-javascript/introduction-to-javascript"
    end
  end

  def icon
    case from
    when 'fcc'
      '/images/fcc-fire-white.png'
    end
  end

  def content
    @content || File.read(content_file)
  end

  def link_view
    Link::View.new(target: self)
  end

  def view
    View.new(target: self)
  end

  class View < Erector::Widget
    include Views

    needs :target
    attr_reader :target

    def content
      text raw(munge(from_markdown(target.content)))
    end

    def munge html
      html.split("\n").map do |line|
        if line == '<!--box-->'
          '<div class="box">'
        elsif line == '<!--/box-->'
          '</div>'
        else
          line
        end
      end.compact.join("\n")
    end
  end

end
