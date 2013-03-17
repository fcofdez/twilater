every 1.minute do
  runner 'BackgroundJobs::Favorites.run!'
end
