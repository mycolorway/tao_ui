import './styles'
import create from '../../shared/icon/create'

# import all icons
req = require.context('../../icons', true, /\.svg$/)
req.keys().forEach(req)

export default { create }
export { create }
