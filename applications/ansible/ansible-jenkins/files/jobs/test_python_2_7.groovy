job('{{DEFAULT_PATH}}/test-python-2-7') {
    scm {
        git {
            remote {
                url({{JENKINS_CONFIG}})
            }
        branch('{{BRANCH}}')
        }
    }
    triggers{
        scm('*/15 * * * *')
    }
    steps{
        shell('cd ./{{PATH}}; ./run_tests.sh')
    }
    publishers{
        cobertura('**/{{PATH}}/coverage.xml'){
            failNoReports(true)
            sourceEncoding('ASCII')
            methodTarget(80, 0, 0)
            lineTarget(80, 0, 0)
            conditionalTarget(80, 0, 0)
        }
        archiveJunit('**/{{PATH}}/*.xml')
    }
}
