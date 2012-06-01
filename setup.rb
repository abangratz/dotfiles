home = File.expand_path("~")
target_dir = File.expand_path(File.dirname(__FILE__))

dotfiles = Dir["*"] - %w[.git setup.rb]

dotfiles.each do |dotfile|
  dotfilename = ".#{dotfile}"
  original_file = File.join(home, dotfilename)
  File.unlink original_file if File.symlink? original_file
  File.rename original_file, "#{original_file}.bak" if File.exist? original_file
  File.symlink File.join(target_dir, dotfile), original_file
end
