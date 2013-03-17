require 'spec_helper'

describe BackgroundJobs::FavoritesParser do

  subject { BackgroundJobs::FavoritesParser }

  it { subject.get_urls(Twitter::Tweet.new(id: 1, text: "hello cruel world")).should be_empty }

  it { subject.get_urls(Twitter::Tweet.new(id: 1, text: "Foro: ¿Qué usos reales le dais a node.js? http://t.co/YCihLRugrw")).should include('http://t.co/YCihLRugrw') }

  it { subject.get_urls(Twitter::Tweet.new(id: 1, text: "Foro: ¿Qué usos reales le dais a node.js? http://t.co/YCihLRugrw http://t.co/K6mCbTSWU5")).should include('http://t.co/YCihLRugrw', 'http://t.co/K6mCbTSWU5') }

end
