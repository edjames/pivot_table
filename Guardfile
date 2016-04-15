guard :rspec, cmd: 'bundle exec rspec', all_on_start: true do
  clearing :on
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
  watch(%r{^lib/pivot_table.rb$}) { 'spec' }
  watch(%r{^lib/pivot_table/(.+)\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb')    { 'spec' }
end
