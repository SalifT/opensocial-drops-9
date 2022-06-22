# Open Social with Drupal 9 on Pantheon

## Drupal 9 with Pantheon's Build Tools and CircleCI Orb

Read more about Drupal 9 with Pantheon's Build Tools and CircleCI Orb on https://github.com/pantheon-systems/drupal-9-with-circleci-orb README.md

## Open Social Project

Read more about Open Social, the team and the process in Drupal.org featured case study and visit the dedicated project website on www.GetOpenSocial.com or follow @OpenSocialHQ on Twitter.

## Before You Begin

Be sure that you:

* Are familiar with your operating system's command line.
* Are using a Unix-based system (Linux or Mac OS X). Windows commands may vary slightly.
* Have created a Pantheon account: https://dashboard.pantheon.io/register. Pantheon accounts are always free for development.
* Have an SSH key generated: https://pantheon.io/docs/ssh-keys, added to your Pantheon dashboard, and loaded in to your local SSH agent.
* You have Install and configure Git and Composer on your local computer.
  * Composer: https://getcomposer.org/download/, the package manager for PHP, installed on your machine.
  * Mac users can use Homebrew: https://brew.sh/ to install both Git and Composer, along with their required dependencies:
    ```
    brew install git composer
    ```

## Install Terminus

A command-line interface that allows you to control your Pantheon account and sites.
Virtually anything you can do in your Pantheon Dashboard, you can script with Terminus. It can also make remote Drush calls on your environments without having Drush installed locally, eliminating incompatibility issues between locally and remotely installed versions of Drush.
As you have a Composer-based site, Terminus will use the version of Drush it finds in vendor/bin/drush when running Drush commands on the platform.
* If you don't have it yet installed on your system, refer to this document https://pantheon.io/docs/terminus/install to install terminus.
* Generate a Machine Token in the Pantheon dashboard by clicking **User Dashboard > Account > Machine Tokens**. Use the Machine Token to authenticate Terminus:
  ```
  terminus auth:login --machine-token=‹machine-token›
  ```
* Verify your session after installation:
  ```
  terminus site:list
  ```
  If your Pantheon site is on the list, installation and authentication were successful!

## Install your Open Social site on Pantheon

To create a copy of this repository including a separate GitHub repo, a CircleCI configuration, and a Pantheon sandbox with OpenSocial, run this command. Be sure to replace `machine-name-for-new-site` with a machine name of your choice and `optional-pantheon-organization-name` with your Pantheon organization name. _Note that having a Pantheon organization is optinal and not required._

```
terminus build:project:create "SalifT/opensocial-drops-9:dev-master" machine-name-for-new-site --stability=dev --team='optional-pantheon-organization-name'
```

After that command completes, verify that Open Social with Drupal 9 has been installed in the Pantheon Dev environment by visiting it in your browser. this command will get you a one-time log in link to the dev environment. Be sure to replace `machine-name-for-new-site` with the machine name you chose above.

```
terminus drush machine-name-for-new-site.dev -- user-login
```

## Install optional modules

If you were to install in a browser using the installer page at /core/install.php, during the walk-through, open social would suggest selecting optional modules to install. However, this is not the case in this scenario. Your site is already installed and only the recommended modules have been installed for now. And you can install the optional modules with terminus

### Install optional modules with terminus

Ensure that your site is in SFTP mode, and then run:

```
terminus drush machine-name-for-new-site.dev -- pm-enable module_machine_name -y
```

Replace `module_machine_name` with the machine name of the module you want to install.
At the time of writing this, here is in the table below the list of the modules suggested by OpenSocial 11.2.2 during the installation in a browser at core/install.php

|  Module name  |  Description  |  module_machine_name  |
| --- | --- | --- |
| dynamic page cache **(recommended)** | Caches parts of the page dynamically for any user. | dynamic_page_cache |
| Inline Form Errors **(recommended)** | Places error messages adjacent to form inputs, for improved usability and accessibility. | inline_form_errors |
| Anonymous page cache **(recommended)** | Cache page for anonymous users. Enable this if you do not have a web server to do this for you. | page_cache |
| private file system **(recommended)** | Use the private file system for uploaded files. Enforces the use of Private Files for content, posts and file uploads (highly recommended!). More info: https://www.drupal.org/docs/8/distributions/open-social/private-files | social_file_private |
| Policies Management | Provides site managers the ability to create policies (e.g. GPDR or Terms & Agreements) that users may/should agree to during registration. | social_gdpr |
| GraphQL API | Enables the GraphQL API for Open Social. - _This is disabled for new platforms as it's experimental. When Open Social defaults to API-first and this module is no longer experimental this can be marked as a default optional (or even required) module._ | social_graphql |
| Open Social help links **(recommended)** | Adds Open Social Links to the main menu. | social_lets_connect_contact |
| Open Social usage data **(recommended)** | Shares usage data to the Open Social team. This helps us prioritise issues and new features making Open Social better. | social_lets_connect_usage |
| Activity filter tag | Allows you to filter content by tag in a activity blocks. | social_activity_filter |
| Album content type | Allows you to organise media in an album like structure. | social_album |
| Book content type | Allows you to organise content in a book like structure. | social_book |
| Comment Attachment | Allows users to attach files to comments they place. | social_comment_upload |
| Content List Blocks | Allows the creation of custom lists of content on dashboards and landing pages. | social_content_block |
| Content Abuse Reporting | Gives users the option to report content to site managers that doesn't fit the community guidelines. | social_content_report |
| Embed Media in Content | Will automatically render previews of links to content on popular websites such as YouTube, Twitter, Vimeo, etc. | social_embed |
| Event Add To Calendar | Provides the ability to add Open Social events to the third party calendars | social_event_addtocal |
| Anonymous Event Enrolments | Allows users to enroll in events without creating an account in the community. | social_event_an_enroll |
| Event Enrolments Export | Allows users to export event enrollees for their events as comma separated value (csv) files. | social_event_enrolments_export |
| Event Organisers | Allows users to add organisers to events besides the creator of the event itself. | social_event_managers |
| Event Enroll Limit | Allows event creators to set limits to the number of people that can enroll. | social_event_max_enroll |
| Event types | Allows events to be organised by event types. | social_event_type |
| Follow User | Provides "Follow User" flag type and related functionality. | social_follow_user |
| Footer | Provides block based on the "Powered by Drupal" block from Drupal core. | social_footer |
| Group Default Routes | Allows group managers to set the default pages on a group for member and non-members. | social_group_default_route |
| flexible groups **(recommended)** | Adds the flexible group type which allows users to create groups and choose the method of joining a group and its content visibility. | social_group_flexible_group |
| Secret groups | Adds the secret group type which allows users to create groups that are not shown on the platform unless you're a member. | social_group_secret |
| Landing Pages | Provides content managers the ability to create landing pages. Landing pages can be used for external users or as guides for authenticated users. | social_landing_page |
| Private Messages | Allows users to send eachother private messages. | social_private_message |
| Profile Fields Settings | Allows a Site Manager to control what fields are available on a profile. | social_profile_fields |
| Profile Organization Tag | Allows Site Managers to add a special tag to the user that will indicate that this is a trusted user to other users. | social_profile_organization_tag |
| Profile Previewer | Allows you to see profile details in a modal window on the hover of the user picture or name. | social_profile_preview |
| Profile Privacy Settings | Allows a Site Manager to control the visibility of profile fields. | social_profile_privacy |
| Social sharing | Will add share links for social media sites to public content. | social_sharing |
| Content Tagging | Allows adding tags to content. Tags can be used in search, content overviews and dashboards. | social_tagging |
| User Export | Provides the ability to export user data as comma separated values (CSV) files. | social_user_export |
| Data Policy | Create data policies and track user agreements as well as informing users. | data_policy |

Install multiple modules at once:

```
terminus drush machine-name-for-new-site.dev -- pm-enable module_machine_name_1 module_machine_name_2 module_machine_name_3 -y
```

Run this command to install all the optional modules:
_Be sure to replace `machine-name-for-new-site` with the machine name of your site._
_Feel free to remove from the command the `modle_machine_name` of the optional modules you don't want to install._

```
terminus drush machine-name-for-new-site.dev -- pm-enable dynamic_page_cache inline_form_errors page_cache social_file_private social_gdpr social_graphql social_lets_connect_contact social_lets_connect_usage social_activity_filter social_album social_album social_book social_comment_upload social_content_block social_content_report social_embed social_event_addtocal social_event_an_enroll social_event_an_enroll social_event_enrolments_export social_event_managers social_event_max_enroll social_event_type social_follow_user social_footer social_group_default_route social_group_flexible_group social_group_secret social_landing_page social_private_message social_profile_fields social_profile_organization_tag social_profile_preview social_profile_privacy social_sharing social_tagging social_user_export data_policy -y
```

## Adding demo content

Install the social demo module.

|  Module name  |  Description  |  module_machine_name  |
| --- | --- | --- |
| Social Demo | Generate demo content and users | social_demo |

```
terminus drush machine-name-for-new-site.dev -- pm-enable social_demo -y
```

After this you might want to clear the cache of your remote drush app on the dev environment.

```
terminus drush machine-name-for-new-site.dev -- cc drush
```

Run drush cache rebuild.

```
terminus drush machine-name-for-new-site.dev -- cr
```

Check to see if the social-demo commands are available to Drush by running the command below.
_At the time of this writing, Open Social 11.2.2 supports Drush version 10 which is also supported by Pantheon. At the time you are reading, Drush version could be 11 or other._
_Note that the commands' syntaxes can slightly differ depending on your drush version._

```
terminus drush machine-name-for-new-site.dev
```

You should see under social-demo the following commands in the list of the drush^10 available commands:

|Commands|Description|
| --- | --- |
|social-demo:add (sda)|Create demo content.|
|social-demo:generate (sdg)|Generate demo content.|
|social-demo:remove (sdr)|Remove demo content|

To add content use the following terminus drush command:

```
terminus drush machine-name-for-new-site.dev demo-content:add file user group topic event event_enrollment comment post like
```

_The order (e.g. file -> user -> group) is important because the content is dependent on each other._

To reemove the content use the following command:

```
terminus drush machine-name-for-new-site.dev demo-content:remove file user group topic event event_enrollment comment post like
```

### More social-demo Commands' usage with terminus drush

Generates demo content for users and topics from the EEA profile:

```
terminus drush machine-name-for-new-site.dev social-demo:add user topic --profile=EEA
```

Removes demo content for users and topics from the EEA profile:

```
terminus drush machine-name-for-new-site.dev social-demo:remove user topic --profile=EEA
```

Generates 100 demo users and 2000 topics:

```
terminus drush machine-name-for-new-site.dev social-demo:generate user:100 topic:2000 event:500 group:100
```

Next, deploy to the Pantheon Test and Live environments. When pull requests are created on your GitHub repo they will generate Multidev environments on Pantheon that clone the database and files from the Live environment. Be sure to replace `machine-name-for-new-site` with the machine name you chose above.

```
terminus env:deploy machine-name-for-new-site.test
terminus env:deploy machine-name-for-new-site.live
```

## The Power of Terminus and Drush

This guide has just scratched the surface of what can be done with Terminus and Drush. While Terminus provides the power to manage most its aspects, tools like Drush give you the power to manage the inner workings of your powered Open Social site on Pantheon. Now you're ready to take the sandbox site, you've setup and explore on your own to see what else is possible.

## See Also

https://pantheon.io/docs/guides/drupal-commandline and more on https://pantheon.io
