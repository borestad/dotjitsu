require 'fileutils'

class String
  def red;       "\e[31m#{self}\e[0m" end
  def green;     "\e[32m#{self}\e[0m" end
  def yellow;    "\e[33m#{self}\e[0m" end
  def pink;      "\e[35m#{self}\e[0m" end
  def bold;      "\e[1m#{self}\e[22m" end
  def italic;    "\e[3m#{self}\e[23m" end
  def underline; "\e[4m#{self}\e[24m" end
end

OK                = '✓ OK      '.green.bold
INSTALLING        = '➤ INSTALL '.green.bold
ERROR             = '✖ ERROR   '.red.bold
EXISTS            = '✓ EXISTS  '.bold.pink
QUESTION          = '★ INPUT   '.yellow.bold

is_osx   = RUBY_PLATFORM.downcase.include?('darwin')
is_linux = RUBY_PLATFORM.downcase.include?('linux')

class Installer

  def symlink
    dotfiles.each do |src|
      dest = "~/#{src}"

      from = File.expand_path(src)
      to = File.expand_path(dest)

      if File.exist?(to)
        puts "#{EXISTS} #{dest} already exists"
      else
        puts "#{OK} Linking #{dest}"
        link(from, to)
      end
    end
  end

  def dotfiles
    Dir['.*'] - %w(. .. .git .DS_Store)
  end

  def link(from, to)
    FileUtils.ln_s(from, to)
  end

end

puts ''

desc 'Bootstrap'

task :symlink do
  Installer.new.symlink
end

task :bootstrap do
  Installer.new.install_homebrew
end

desc 'Install'
task :install do
  system %Q{./bin/dot}
end

# Always return new line
at_exit { puts '' if $!.nil? }
