module ApplicationHelper
  def markdown(content)
    markdown = Redcarpet::Markdown.new(RedcarpetMdtyper, autolink: true, tables: true, fenced_code_blocks: true)
    markdown.render(content)
  end
end
