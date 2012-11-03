module ApplicationHelper

  # Returns the full title on a per-page basis.       # Documentation comment
  def full_title(page_title) # Method definition
    base_title = "C.C.C." # Variable assignment
    if page_title.empty? # Boolean test
      base_title # Implicit return
    else
      "#{base_title} | #{page_title}" # String interpolation
    end
  end

  def markdown(text)
    if text.nil?
      text = ""
    end
    options = {
        :autolink => true,
        :space_after_headers => true,
        :no_intra_emphasis => true
        #,
        #  :fenced_code_blocks => true
    }
    rndr = Redcarpet::Render::HTML.new(:hard_wrap => true)
    markdown = Redcarpet::Markdown.new(rndr, options)
    markdown.render(text).html_safe
  end

  def my_pluralize(nb, mess_0, mess_1, mess_2)
    if nb==0
      return mess_0
    else
      if nb==1
        return mess_1
      else
        return mess_2
      end
    end
  end

end
