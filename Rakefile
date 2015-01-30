file 'swapf'
desc "run tests"
task default: :test
task :test => :test_output do
  sh "cat test_output"
end
file :test_output => Rake::FileList.new('swapf', 'spec/*spec.sh' ) do
  warn "Rerunning Tests"
  sh "bash spec/*_spec.sh >| test_output"
end
