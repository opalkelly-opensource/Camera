/**
 * Error handling
 */
import colors from 'colors';
import notify from 'gulp-notify';

/**
 * Shows error(s) in OS notification and terminal window.
 * @param {object} error
 * @return {string}
*/
const handleErrors = (error) => {
  let fullMessage = 'Error in **' + error.plugin + '**:' + error.message;

  notify.onError({
    title: error.plugin,
    message: error.message,
    sound: 'Frog'
  })(error);

  console.log(colors.bgRed.white(fullMessage));

  this.emit('end');
};

/**
 * Export
 */
export default handleErrors
