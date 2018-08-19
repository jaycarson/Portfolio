job('{{DEFAULT_PATH}}/test-python-2-7') {
    scm {
        git {
            remote {
                url({{PORTFOLIO}})
            }
        branch('{{BRANCH}}')
        }
    }
    triggers{
        scm('*/15 * * * *')
    }
    steps{
        shell('cd ./{{PATH}}; pycodestyle --first Euler001.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler002.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler003.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler004.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler005.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler006.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler007.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler008.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler009.py')
        shell('cd ./{{PATH}}; pycodestyle --first Euler010.py')
        shell('cd ./{{PATH}}; pycodestyle --first euler_tests.py')
        shell('cd ./{{PATH}}; python -m xmlrunner euler_tests.py || true')
        shell('cd ./{{PATH}}; coverage run euler_tests.py || true')
        shell('cd ./{{PATH}}; coverage xml')
        shell('cd ./{{PATH}}; rm *.pyc')
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
