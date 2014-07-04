class Subdomain
  def self.matches?(request)

    case request.host
    when "mdwriter.dev", nil
      false
    else
      true
    end  
  end

end
