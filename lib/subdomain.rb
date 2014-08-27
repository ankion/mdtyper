class Subdomain
  def self.matches?(request)

    case request.host
    when Rails.application.secrets.domain_name, nil
      false
    else
      true
    end  
  end

end
