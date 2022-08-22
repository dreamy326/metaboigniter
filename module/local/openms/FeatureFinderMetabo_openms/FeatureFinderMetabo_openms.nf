process FeatureFinderMetabo_openms  {
    label 'openms'
    //label 'process_low'
    tag "$mzMLFile"
    

    //conda (params.enable_conda ? "bioconda::openms=2.8.0" : null)
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        //'https://depot.galaxyproject.org/singularity/openms:2.8.0--h7ca0330_2' :
        //'quay.io/biocontainers/openms:2.8.0--h7ca0330_2' }"


    input:
    path mzMLFile 
    //each path(setting_file) 

    output:
    path "${mzMLFile.baseName}.featureXML" , emit: files_with_features
    path "${mzMLFile.baseName}.mzML"       , emit: file_with_chromatograms
    path "versions.yml"                    , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''

    """
    FeatureFinderMetabo \\
        -in $mzMLFile \\
        -out ${mzMLFile.baseName}.featureXML \\
        -out_chrom ${mzMLFile.baseName}.mzML \\
        $args \\
        -threads $task.cpus
    

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        openms: \$( openms --version | sed -e "s/openms v//g" ))
    END_VERSIONS

    """
}

