class RedcarpetMdtyper < Redcarpet::Render::HTML
  def header(text, header_level)
    "<h#{header_level + 1}>#{text}</h#{header_level + 1}>"
  end
end
