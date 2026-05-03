/**
 * Deployment information that is stored for each dev separately
 */
module.exports = {
  'staging': {
    'hostname': 'sprawsm.mystableservers.com',
    'username': 'sprawsm',
    'destination': '/home/sprawsm/web/superaweso.me/public_html/ok-camera',
    'exclude': []
  },
  'local': {
      'source': [
        './dist/assets'
      ],
      'destination': '~/Workspace/web/test/123',
      'exclude': []
  },
}
