class Scrapper
  def self.scrape_lever_page(company_name)
    url = "https://jobs.lever.co/#{s(company_name)}"
    doc = Nokogiri::HTML(open(url))
    posts = doc.css(".posting-title")
    jobs = posts.map do |post|
      serialized = {
        title: post.at_css("h5").text,
        location: post.at_css(".sort-by-location").text,
        team: post.at_css(".sort-by-team").text,
        commitment: post.at_css(".sort-by-commitment").text,
        url: post["href"] #this will be unique ()
      }

      description_doc = Nokogiri::HTML(open(serialized[:url]))
      desc = description_doc.at_css(".content .section-wrapper.page-full-width:not(.accent-section)")
      serialized[:description] = desc.text
      serialized
    end
    jobs
  end

  def self.scrape_greenhouse_page(company_name)
    url = "https://boards.greenhouse.io/#{s(company_name)}"
    doc = Nokogiri::HTML(open(url))
    posts = doc.css(".opening")
    jobs = posts.map do |post|
      serialized = {
        title: post.at_css("a").text,
        location: post.at_css(".location").text,
        url: "https://boards.greenhouse.io#{post.at_css('a')['href']}"
      }

      description_doc = Nokogiri::HTML(open(serialized[:url]))
      desc = description_doc.at_css("#content")
      serialized[:description] = desc.text.strip
      serialized
    end
    jobs
  end

  def self.scrape_angel_list_page(company_name)
    url = "https://angel.co/#{s(company_name)}/jobs"
    doc = Nokogiri::HTML(open(url, "User-Agent" => "Im scrapping yo"))
    posts = doc.css(".job-listing-role")
    jobs = posts.map do |post|
      meta = post.at_css(".listing-data").text.split("·").map(&:strip)
      serialized = {
        title: post.at_css(".group").text,
        team: post.at_css(".listing-title a").text,
        location: meta.first,
        url: post.at_css(".listing-title a")['href'],
        commitment: meta[1],
        salary: meta[2] + "·" + meta[3],
      }

      description_doc = Nokogiri::HTML(open(serialized[:url], "User-Agent" => "Im scrapping yo"))
      desc = description_doc.at_css(".job-description")
      serialized[:text] = desc.text.strip
      serialized
    end
    jobs
  end

  def self.s(name)
    URI.escape(name.gsub(" ", "").downcase)
  end
end