# frozen_string_literal: true

namespace :redmine do
  namespace :additionals do
    desc <<-DESCRIPTION
    Reset resently used dashboards from user preferences.

    Example:
      bundle exec rake redmine:additionals:reset_resently_dashboards RAILS_ENV=production
    DESCRIPTION
    task reset_resently_dashboards: :environment do
      cnt = 0
      UserPreference.all.each do |pref|
        next if pref.others.blank? || pref.others[:recently_used_dashboards].blank?

        pref.others.delete :recently_used_dashboards
        pref.save!
        cnt += 1
      end

      puts "Resently dashboard_ids have been removed from #{cnt} user preferences."
      exit 0
    end
  end
end
