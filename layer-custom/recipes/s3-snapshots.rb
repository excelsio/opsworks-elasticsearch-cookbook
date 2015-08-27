template "/usr/local/sbin/setup-elastic-snapshot" do
  source "elasticsearch.setup-snapshot.sh.erb"
  mode 0755
end

cookbook_file "/usr/local/sbin/take-elastic-snapshot" do
  source "elasticsearch.take-snapshot.sh"
  mode 0755
end

execute "setup the S3 snapshot" do
  command "/usr/local/sbin/setup-elastic-snapshot localhost s3_#{node[:elasticsearch][:cluster][:name]}"
end

cron "take S3 snapshot" do
  minute "0,30"
  command "/usr/local/sbin/take-elastic-snapshot localhost s3_#{node[:elasticsearch][:cluster][:name]}"
end
