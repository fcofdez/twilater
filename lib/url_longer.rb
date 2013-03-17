class UrlLonger
  def long_url! url
    Faraday.get(url).headers[:url]
  end
end
