module Parser
  class Twitter
    def parse(message)
      if(message.from_user == "aaa")
        return Brand.find_by_name("cleo pires"), Opinion.find_by_name("uma delicia")
      elsif (message.from_user == "bbb")
        return Brand.find_by_name("locaweb"), Opinion.find_by_name("uma bosta")
      end
      return nil, nil
    end
  end
end
