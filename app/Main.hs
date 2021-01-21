import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import Network.HTTP.Conduit (newManager, tlsManagerSettings)

main :: IO ()
main = do
    manager <- newManager tlsManagerSettings
    warp 3000 (App manager)
