@servers(['dev' => ['forge@54.144.19.141']])

// rsync -r . forge@54.144.19.141:/home/forge/default/storage/images
// dump db (might have to do that separately due to homestead): cd ~/Code && pg_dump -U homestead -h localhost -W -d punchcard > punchcard-schema.sql 
// copy dump: scp punchcard-schema.sql forge@inverseapp.today:
// import dump: dropdb forge && createdb forge && cd ~/ && psql forge < punchcard-schema.sql
// deploy code at Forge
// run search indexer: (sic) cd ~/default && rm storage/tnt/project_user.index && php artisan scout:import App\\SearchProjectsUsers ; php artisan scout:import App\\SearchProjectsUsers
//
@task('disk-free', ['on' => 'dev'])
    df
@endtask
