desc "This task is called by the Heroku scheduler add-on"
task :update_contents => :environment do
  puts "Updating contents..."
  BackgroundJobs::Favorites.update_contents! 
  puts "done."
end
