require 'erector'

class Courses < Erector::Widget

  external :style, <<-CSS
  table.courses {
    border: 2px solid gray;
    border-collapse:collapse;
    margin-left: 10em;
    box-shadow: #c8c8f1 2px 2px 4px;

  }

  table.courses ul {
    list-style: none;
    -webkit-margin-before: 0;
    -webkit-margin-after: 0;
    -webkit-margin-start: 0;
    -webkit-margin-end: 0;
    -webkit-padding-start: 0;
  }
  table.courses td.lessons {
    font-size: 90%;
    padding-top: .5em;
  }
  table.courses, table.courses td, table.courses th {
    border: 1px solid black;
    padding: 4px 8px 8px;
  }
  table.courses th {
    text-shadow: 1px 1px #ededed;
  }
  table.courses td {
  }
  table.courses tr:nth-child(1) {
    background-color: #B3C8E8;
  }
  table.courses tr:nth-child(even) {
    background-color: #EEEEF2;
  }
  table.courses a {
    text-decoration: none;
    display: block;
    padding: 2px;
  }
  table.courses a:hover {
    text-decoration: underline;
    background-color: #B3C8E8;
  }
  table.courses a:visited {
    color: black;
  }

  CSS

    module ::Enumerable
      def select_with_index
        index = -1
        select { |x| yield(x, index += 1) }
      end
      def odds
        select_with_index {|x,i| i.odd?}
      end
      def evens
        select_with_index {|x,i| i.even?}
      end
    end


  def content
    widget Breadcrumbs, display_name: display_name

    courses_table @courses
  end

  def courses_table courses
    table.courses {
      tr {
        th "Course"
        th "Lessons"
        th "Labs"
      }
      courses.each do |course|
        tr {
          th(valign: "top") {
            a course.display_name, href: course.href
          }
          td.lessons(valign: "top") {
            widget course, {}, :content_method_name => :list_lessons
          }
          td.lessons(valign: "top") {
            widget course, {}, :content_method_name => :list_labs
          }
        }
      end
    }
  end

  def display_name
    "Lessons"
  end

  def href
    "/lessons"
  end

end
