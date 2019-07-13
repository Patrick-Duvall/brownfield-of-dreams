import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Rails from 'rails-ujs'

const application = Application.start()
Rails.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
