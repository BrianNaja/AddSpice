module ApplicationHelper

  def markdown(content)
   @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: false, fenced_code_blocks: true, tables: true)
   @markdown.render(content)
  end

end
