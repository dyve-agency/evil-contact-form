def log(txt)
  # 31 red
  # 32 green
  # 33 yellow
  # 35 pink
  color_code = 32
  puts "\e[#{color_code}m#{txt}\e[0m"
end

def execute(cmd)
  log "#\t `#{cmd}`"
  system cmd
end

task :deploy do
  log "### Deploying evil-contact-form"
  execute "rsync -P -r -v -e ssh ./* railsbait:~/evil_contact"
  log "!!! Make sure to run `bundle install` on the server !!!"
  log "!!! You now need to restart nginx !!!"
end

task :start do
  execute "bundle exec mailcatcher -f &"
  execute "bundle exec rackup config.ru"
end
