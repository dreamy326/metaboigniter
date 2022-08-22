process MapAlignerPoseClustering_openms  {
    label 'openms'
    tag "$rdata_files"
    
    //conda (params.enable_conda ? "bioconda::openms=2.8.0" : null)
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        //'https://depot.galaxyproject.org/singularity/openms:2.8.0--h7ca0330_2' :
        //'quay.io/biocontainers/openms:2.8.0--h7ca0330_2' }"


    input:
    path rdata_files
    //each path(setting_file) 

    output:
    path "${rdata_files.baseName}.featureXML" , emit: corrected_files
    path "${rdata_files.baseName}.trafoXML"   , emit: transferred_files
    path "versions.yml"                       , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''

    """
    MapAlignerPoseClustering \\
        -in $rdata_files \\
        -out ${rdata_files.baseName}.featureXML \\
        -trafo_out ${rdata_files.baseName}.trafoXML \\
        $args \\
        -threads $task.cpus
    

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        openms: \$( openms --version | sed -e "s/openms v//g" ))
    END_VERSIONS

    """
}

