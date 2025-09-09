/*
 * Deployment information that is stored for each dev separately
 */
module.exports = {
  'staging': {
    'hostname': 'server hostname or IP address',
    'username': 'ssh username',
    'destination': 'destination path e.g. /var/www/user-name/public_html/project-name',
    'exclude': []
  },
  'local': {
      'source': ['source files and folders'],
      'destination': 'destination path e.g. ~/Sites/project-X',
      'exclude': []
  },
}
