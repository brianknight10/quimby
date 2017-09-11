namespace :docker do
  desc 'Remove pre-existing Docker container'
  task :clean do
    system "docker images | grep \"quimby\" | awk '{print $3}' | xargs docker rmi"
  end

  desc 'Build Docker image'
  task :build, [:version] => [:clean] do |_t, args|
    args.with_defaults(version: 'latest')
    system "docker build -t 'brianknight10/quimby:#{ENV['version']}' ."
  end

  desc 'Push Docker image to the repository'
  task :deploy, [:username, :password, :version] do |_t, args|
    args.with_defaults(version: 'latest')
    Rake.application.invoke_task("docker:build[#{ENV['version']}]")

    system "docker login -u=\"#{ENV['username']}\" -p=\"#{ENV['password']}\""
    system "docker push 'brianknight10/quimby:#{ENV['version']}'"
  end
end
