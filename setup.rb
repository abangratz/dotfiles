require 'fileutils'
require 'erb'
home = File.expand_path("~")
target_dir = File.expand_path(File.dirname(__FILE__))

dotfiles = Dir["*"] - %w[.git setup.rb templates]

dotfiles.each do |dotfile|
  dotfilename = ".#{dotfile}"
  original_file = File.join(home, dotfilename)
  File.unlink original_file if File.symlink? original_file
  File.rename original_file, "#{original_file}.bak" if File.exist? original_file
  File.symlink File.join(target_dir, dotfile), original_file
end

templatefiles = Dir['templates/**/*.erb']

templatefiles.each do |filename|
  outputname = filename.gsub(%r[templates/(.*)\.erb], '.\1')
  outputdir = File.join(home, File.dirname(outputname))
  FileUtils.mkdir_p outputdir
  FileUtils.rm_f File.join(home, outputname)
  erb = ERB.new(File.read(filename))
  File.open(File.join(home, outputname), 'w+') do |f|
    f.print(erb.result(binding))
  end
end

FileUtils.mkdir_p(File.join(home, 'projects', 'github', 'other')) 
puts `git clone https://github.com/muennich/urxvt-perls #{home}/projects/github/other/urxvt-perls` unless File.exist?("#{home}/projects/github/other/urxvt-perls")
