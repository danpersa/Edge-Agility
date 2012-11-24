EdgeAgility.Router = Ember.Router.extend({
  enableLogging: true,
  location: 'hash',

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      selectProject: function(router, event) {
        $.get('/projects/' + event.context.get('id') + '/set_as_current', function(data) {
          EdgeAgility.router.get('projectsMenuController').selectProject(event.context.get('id'));
        });
      },
      // You'll likely want to connect a view here.
      connectOutlets: function(router) {
        router.get('applicationController').connectOutlet({
          outletName: 'loginMenu',
          viewClass: EdgeAgility.LoginMenuView,
          controller: router.get('loginMenuController')
        });
        router.get('loginMenuController').addObserver('content', function() {
          if (router.get('loginMenuController').get('content') != null) {
            router.get('projectsMenuController').set('visible', true);
          } else {
            router.get('projectsMenuController').set('visible', false);
          }
        });
        router.get('loginMenuController').enter();
        router.get('applicationController').connectOutlet({
          outletName: 'projectsMenu',
          viewClass: EdgeAgility.ProjectsMenuView,
          controller: router.get('projectsMenuController')
        });
        router.get('applicationController').connectOutlet({
          outletName: 'projectMenu',
          viewClass: EdgeAgility.ProjectMenuView,
          controller: router.get('projectMenuController')
        });
        router.get('applicationController').connectOutlet({
          outletName: 'scrumBoardMenu',
          viewClass: EdgeAgility.ScrumBoardMenuView,
          controller: router.get('scrumBoardMenuController')
        });
        router.get('applicationController').connectOutlet({
          outletName: 'backlogMenu',
          viewClass: EdgeAgility.BacklogMenuView,
          controller: router.get('backlogMenuController')
        });
        router.get('projectsMenuController').findAll();
        router.get('loginMenuController').enter();
      }

      // Layout your routes here...
    }),
    backlog:  Ember.Route.extend({
      route: '/backlog',
      enter: function (router) {
        console.log("The backlog sub-state was entered.");
      },
      showNewIteration: function(router) {
        router.transitionTo('backlog.newIteration', {});
      },
      connectOutlets: function(router, context) {
        router.get('applicationController').connectOutlet({
          viewClass: EdgeAgility.BacklogView,
          controller: router.get('backlogController'),
          context: EdgeAgility.store.findAll(EdgeAgility.Iteration)
        });
      },
      index: Ember.Route.extend({
        route: '/',
        enter: function (router) {
          console.log("The backlog index sub-state was entered.");
        },
        connectOutlets: function(router, context) {
          router.get('backlogController').connectOutlet({
            outletName: 'quickBar',
            viewClass: EdgeAgility.QuickUserStoryView,
            controller: router.get('quickUserStoryController')
          });
          router.get('quickUserStoryController').enterNew();
        }
      }),
      newIteration: Ember.Route.extend({
        route: '/new-iteration',
        cancelNewIteration: function(router) {
          router.transitionTo('backlog.index');
        },
        connectOutlets: function(router, context) {
          router.get('backlogController').connectOutlet({
            outletName: 'newIteration',
            viewClass: EdgeAgility.NewIterationView,
            controller: router.get('newIterationController')
          });
          router.get('newIterationController').enterNew();
        }
      })
    }),
    userStories:  Ember.Route.extend({
      route: '/user_stories',
      showNewUserStory: function(router) {
        router.transitionTo('userStories.new', {});
      },
      editUserStory: function(router, event) {
        router.transitionTo('userStories.edit', event.context);
      },
      destroyUserStory: function(router, event) {
        event.context.deleteRecord();
        EdgeAgility.store.commit();
        router.transitionTo('userStories.index');
      },
      enter: function (router) {
        console.log("The user_stories sub-state was entered.");
      },
      connectOutlets: function(router, context) {
        router.get('applicationController').connectOutlet("userStories", EdgeAgility.store.findAll(EdgeAgility.UserStory));
      },
      index: Ember.Route.extend({
          route: '/',
          enter:  function(router) {
            console.log("The user_stories index sub-state was entered.");
          },
          connectOutlets: function(router, context) {
            router.get('applicationController').connectOutlet("userStories");
          }
      }),
      show: Ember.Route.extend({
          route: '/:user_story_id',
          connectOutlets: function(router, context) {
            router.get('applicationController').connectOutlet('showUserStories');
          }
      }),
      edit: Ember.Route.extend({
          route: '/:user_story_id/edit',
          enter: function(router) {
            
          },
          cancelEdit: function(router) {
            router.transitionTo('userStories.index');
          },
          connectOutlets: function(router, context) {
            var userStoriesController = router.get('userStoriesController');
            userStoriesController.connectOutlet('editUserStory', context);
            router.get('editUserStoryController').enterEdit();       
          },
          exit: function(router) {
            router.get('editUserStoryController').exitEdit();
          }
      }),
      new: Ember.Route.extend({
          route: '/new',
          cancelNew: function(router) {
            router.transitionTo('userStories.index');
          },
          connectOutlets: function(router, context) {
            router.get('userStoriesController').connectOutlet('newUserStory');
            router.get('newUserStoryController').enterNew();
          }
      })
    })
  })
});