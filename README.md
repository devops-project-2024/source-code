# Crispy-kitchen Project

## Pipeline 

Running a pipeline in Jenkins involves several steps, from setting up Jenkins itself to creating and executing the pipeline. Here's a step-by-step guide to get you started:

### 1. Install Jenkins

Ensure Jenkins is installed on your server and follow the installation instructions for your specific operating system.

### 2. Access Jenkins

- Open a web browser and navigate to your Jenkins instance. This is typically at `http://your-jenkins-server:8080`.
- Complete the initial setup by following the setup wizard, installing the suggested plugins, and setting up the first admin user.

### 3. Create a New Pipeline Job

- On the Jenkins dashboard, click on “New Item”.
- Enter a name for your pipeline in the “Enter an item name” field.
- Select “Pipeline” from the available options, then click "OK".


### 4. Configure the Pipeline

- In the configuration page, scroll down to the “Pipeline” section.
- You have several options to define your pipeline script:
  - **Directly in Jenkins**: Select “Pipeline script” and enter your Groovy-based Jenkins Pipeline code in the text area.
  - **From SCM (Source Control Management)**: Select “Pipeline script from SCM”, choose your SCM type (e.g., Git), and fill in the repository details and path to your Jenkinsfile.

### 5. Save and Run the Pipeline

- Click “Save” to save your pipeline configuration.
- To execute the pipeline, click “Build Now” on the project page.
- Monitor the build’s progress by clicking on the build number in the “Build History” and then on “Console Output”.

### 6. Review the Output

- Once the pipeline execution is complete, review the output in the “Console Output” to check if everything ran as expected.
- If there are any issues, the error messages in the console output can help troubleshoot.

### 7. Make Changes and Iterate

- If you need to make changes to the pipeline, go back to the project page, click “Configure”, and adjust the pipeline script or SCM settings as necessary.
- Save the changes and run the pipeline again to test.

### Additional Tips

- **Jenkinsfile**: For more complex pipelines, it’s recommended to use a Jenkinsfile, which is a text file that contains the pipeline definition. The Jenkinsfile is typically stored in your SCM, allowing you to version control your pipeline alongside your application code.
- **Pipeline Syntax Helper**: Jenkins provides a “Pipeline Syntax” helper tool (accessible from the pipeline configuration page) to generate pipeline code snippets for various steps.
- **Plugins**: Depending on your pipeline's needs, you might need to install additional plugins in Jenkins. You can do this from the “Manage Jenkins” → “Manage Plugins” section.

## Plugins 

To install plugins in Jenkins, follow these step-by-step instructions:

### 1. Access Jenkins

- Open your web browser and go to your Jenkins instance (usually `http://your-jenkins-server:8080`).
- Log in with your admin credentials to access the Jenkins dashboard.

### 2. Open Manage Jenkins

- On the Jenkins dashboard, click on “Manage Jenkins” to access the Jenkins management console.

### 3. Access Manage Plugins

- Inside the Manage Jenkins page, look for the “Manage Plugins” link and click on it. This will take you to the Plugin Manager.

### 4. Find the Plugin

- You will see four tabs: Updates, Available, Installed, and Advanced.
- To install new plugins, go to the “Available” tab.
- Use the search bar at the top-right of the page to find the plugin you want to install. You can search by the plugin name or a functionality keyword. ( docker pipeline, Sonarqube scanner)

### 5. Select Plugins to Install

- Once you find the plugin(s) you want to install, check the box next to the plugin name.
- You can select multiple plugins to install them in one batch.

### 6. Install the Plugin

- After selecting the plugin(s), scroll down and click the “Install without restart” or “Download now and install after restart” button.
  - “Install without restart” tries to install the plugin without restarting Jenkins, though some plugins may still require a restart to be fully integrated.
  - “Download now and install after restart” will download the plugin and complete the installation process when Jenkins restarts.

### 7. Restart Jenkins (if necessary)

- If the installed plugin(s) require a restart, you’ll be prompted to do so. You can either:
  - Click the “Restart Jenkins when installation is complete and no jobs are running” checkbox to let Jenkins automatically restart once the current jobs are completed.
  - Manually restart Jenkins by navigating to `http://your-jenkins-server:8080/restart`, which forces a restart immediately.

### 8. Verify Plugin Installation

- After Jenkins restarts, log in again, go to “Manage Jenkins” → “Manage Plugins”, and switch to the “Installed” tab.
- Verify that your new plugin(s) are listed in the installed plugins list.

### Additional Tips

- **Plugin Dependencies**: When installing a plugin, Jenkins will automatically install any dependencies required by that plugin. Ensure that your Jenkins instance has internet access to download these plugins and dependencies.
- **Regular Updates**: Regularly check the “Updates” tab in the Plugin Manager to keep your plugins up to date. This helps in fixing known issues and improving security.

## Adding Third party Credential (Github, Dockerhub, and Sonarqube)

Adding third-party credentials in Jenkins allows you to securely store and manage sensitive information such as passwords, secret keys, and tokens. Here's how to add third-party credentials in Jenkins:

### 1. Access Jenkins

- Open your web browser and navigate to your Jenkins instance (usually at `http://your-jenkins-server:8080`).
- Log in with your credentials.

### 2. Open Manage Jenkins

- On the Jenkins dashboard, click on “Manage Jenkins” to enter the Jenkins management console.

### 3. Access Manage Credentials

- Look for the “Manage Credentials” link in the Manage Jenkins page and click on it.

### 4. Choose the Store

- You will see a list of Stores and Domains. Typically, you'll add credentials to the Jenkins global store, so click on “(global)” under the “Jenkins” store.

### 5. Add Credentials

- Inside the global credentials domain, click on “Add Credentials” on the left sidebar.

### 6. Select Credential Type

- Choose the appropriate type of credential from the “Kind” dropdown menu. Common types include:
  - **Username with password**: Use this for credentials that consist of a username and a password.
  - **Secret text**: Use for secret information like API tokens.
  - **SSH Username with private key**: Use if you need to store an SSH key.
  - **Secret file**: Use to upload a file containing secrets, such as certificates.

### 7. Enter Credential Details

- Fill in the form with the details of the credential. The fields will vary based on the type of credential you selected.
  - For example, if you’re adding a “Username with password” credential, you will need to provide the username, password, ID (optional), and a description.
  - If adding an “SSH Username with private key”, provide the username, select the method to enter the key, paste or upload the key, and optionally provide a passphrase.

### 8. Save the Credential

- Click the “OK” button to save the credential.

### 9. Verify the Credential

- After saving, you should see the credential listed in the domain. Verify that it appears correctly.

### Additional Tips

- **Credential ID**: You can set a custom ID for each credential to easily reference it in your Jenkins pipelines and jobs. If you don’t specify an ID, Jenkins will generate a unique one for you.
- **Security**: Be mindful of security practices. Only add credentials that are necessary for your Jenkins jobs and ensure that access to these credentials is tightly controlled.
- **Usage in Jobs/Pipelines**: You can reference these credentials in your Jenkins jobs or pipelines using the credentials binding plugin, or directly in pipeline scripts by their ID.

By following these steps, you can add third-party credentials in Jenkins, enabling your CI/CD pipelines to securely access the resources they need.