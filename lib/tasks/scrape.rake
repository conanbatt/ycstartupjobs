
namespace :scrape do
  desc "Fetch Single Company Jobs from Lever"
  task :lever, [:company_name] => :environment do |t,args|
    @jobs = Scrapper.scrape_lever_page args[:company_name]
    p @jobs
  end

  desc "Fetch Single Company Jobs from Greenhouse"
  task :greenhouse, [:company_name] => :environment do |t, args|
    @jobs = Scrapper.scrape_greenhouse_page args[:company_name]
    p @jobs
  end

  desc "Fetch Single Company Jobs from AngelList"
  task :angel_list, [:company_name] => :environment do |t, args|
    @jobs = Scrapper.scrape_angel_list_page args[:company_name]
    p @jobs
  end

  desc "Scrapes every company in the db"
  task :all, [:sources] => :environment do |t, args|
    args[:sources].split(",").each do |source|
      not_founds = 0
      invalid_data = 0
      @jobs = []
      #Company.all.map.with_index do |company, i|
      Company.where(name: "Scribd").all.map.with_index do |company, i|
        p "Fetching #{company.name}"
        p "#{i}/#{Company.count}"
        begin
          Rake::Task["scrape:#{source}"].execute(company_name: company.name.downcase)
          p "Jobs Found: #{@jobs.length}"
          @jobs.map do |job|
            #debugger
            if(job[:url])
              job[:company_id] = company.id
              JobOpening
                .find_or_initialize_by(url: job[:url])
                .update_attributes!(job)
            else
              invalid_data += 1
            end
          end
        rescue OpenURI::HTTPError => e
          not_founds += 1
        end
      end
      p "Source: #{source}"
      p "Not Found: #{not_founds} of #{Company.count}"
      p "Invalid Data: #{invalid_data} of #{Company.count}"
    end
  end
end

#https://boards.greenhouse.io/scribd