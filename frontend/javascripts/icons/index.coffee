# import all icons
req = require.context('../../icons', true, /\.svg$/)
req.keys().forEach(req)

import createIcon from './create'

export default { createIcon }
export { createIcon }
