require 'csv'
namespace :dev do

  task :import_registration_csv_file => :environment do
    event = Event.find_by_friendly_id("fullstack-meetup")
    tickets = event.tickets

    success = 0
    failed_records = []

    CSV.foreach("#{Rails.root}/tmp/registrations.csv") do |row|
      registration = event.registrations.new( :status => "confirmed",
                                   :ticket => tickets.find{ |t| t.name == row[0] },
                                   :name => row[1],
                                   :email => row[2],
                                   :cellphone => row[3],
                                   :website => row[4],
                                   :bio => row[5],
                                   :created_at => Time.parse(row[6]) )

      if registration.save
        success += 1
      else
        failed_records << [row, registration]
      end
    end

    puts "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"

    failed_records.each do |record|
      puts "#{record[0]} ---> #{record[1].errors.full_messages}"
    end
  end

end
