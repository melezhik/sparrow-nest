module_run 'Cpanm::GitHub', %(
    user    => "melezhik",        # github user, required
    project => "sparrow-nest",    # GitHub project, required
    branch  => "master"
);


bash "nestd stop";
bash "nestd start --port 80";
bash "nestd status", %(
  expect_stdout => 'nestd is running'
);
