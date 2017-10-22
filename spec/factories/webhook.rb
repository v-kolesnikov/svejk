# frozen_string_literal: true

Factory.define :webhook do |f|
  f.name { fake(:lorem, :word) }
  f.url { fake(:internet, :url, 'app.localhost') }
  f.events { %w[user.signed issue.created] }
end
