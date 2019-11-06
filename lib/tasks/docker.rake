namespace :docker do
  desc 'Remove pre-existing Docker container'
  task :clean do
    system "docker images | grep \"quimby\" | awk '{print $3}' | xargs docker rmi"
  end

  desc 'Build Docker image'
  task :build, [:version] => [:clean] do |_t, args|
    args.with_defaults(version: 'latest')
    Rake.application.invoke_task('assets:clobber')
    Rake.application.invoke_task('assets:precompile')

    system "docker build -t 'brianknight10/quimby:#{args[:version]}' ."
  end

  desc 'Push Docker image to the repository'
  task :deploy, [:username, :password, :version] do |_t, args|
    args.with_defaults(version: 'latest')
    Rake.application.invoke_task("docker:build[#{args[:version]}]")

    system "docker login -u=\"#{args[:username]}\" -p=\"#{args[:password]}\""
    system "docker push 'brianknight10/quimby:#{args[:version]}'"
  end
end
