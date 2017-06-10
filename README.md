# php : Executable for AWS Lambda

Our company has a significant investment in PHP development as well as AWS. We desire the ability to run [PHP](http://www.php.net/) in [AWS Lambda](https://aws.amazon.com/lambda/) despite the fact that it isn't formally supported. We created this system for building PHP Executables that will run properly in AWS Lambda Functions.

# Using PHP for AWS Lambda

We have tested building PHP Versions:

 - 7.1
 - 7.0
 - 5.6

We keep pre-baked archives on the release page:

https://github.com/stechstudio/php-lambda/releases

Un-archive that and skip the entire build process if you like.

# Building PHP for AWS Lambda

The process depends on [Docker](https://docs.docker.com/engine/installation/).

Clone this repository and run:

    $ ./build.sh 7.1.5

When complete you should have something like `php-7.1.5-lambda.tar.gz` in your working directory.

# Using php in an AWS Lambda Package

Creating a [Lambda Deployment Package](http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html) is beyond the scope of this read me. You must be familiar with the process.

Go about creating your Deployment Package as normal, and extract the php tar file into your base directory. This will result in three new directories if they didn't  exist:

      ./bin
      ./lib
      ./include

You will find php at `./bin/php` along with all the other executables we created. Adding this to your Deployment Package will add about 10M to the package size.

In your code you can reference `/var/task/bin/php` and you will need to ensure you customize the Lambda Function Environment Variable `LD_LIBRARY_PATH=/var/task/lib` from there you should be good to go!
