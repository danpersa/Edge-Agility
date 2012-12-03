EdgeAgility.Router = Ember.Router.extend({
  enableLogging: true,
  location: 'hash',

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',
      selectProject: function(router, event) {
        console.log("Selecting project with id: ");
        console.log(event.context.get('id'));
        EdgeAgility.router.get('projectsMenuController').selectProject(event.context.get('id'));
        EdgeAgility.router.transitionTo('index.backlog.index');
      },
      showEditProject: function(router, event) {
        router.transitionTo('root.index.projects.edit', event.context);
      },
      showNewProject: function(router) {
        router.transitionTo('root.index.projects.new', {});
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
        router.get('applicationController').connectOutlet({
          viewClass: EdgeAgility.ProjectsView,
          controller: router.get('projectsMenuController')
        });
      },
      dashboard: Ember.Route.extend({
        route: '/dashboard',
        enter: function(router) {
          console.log("The dashboard sub-state entered.");
        }
      }),
      scrumBoard: Ember.Route.extend({
        route: '/scrum_board',
        showBacklog: function(router) {
          router.transitionTo('root.index.backlog.index', {});
        },
        enter: function (router) {
          console.log("The scrumbBoard sub-state was entered.");
        },
        connectOutlets: function(router, context) {
          router.get('applicationController').connectOutlet({
            viewClass: EdgeAgility.ScrumBoardView,
            controller: router.get('scrumBoardController')
          });
          router.get('scrumBoardController').findAll()
        }
      }),
      backlog:  Ember.Route.extend({
        route: '/backlog',
        enter: function (router) {
          console.log("The backlog sub-state was entered.");
          var backlogController = EdgeAgility.router.get('backlogController')
          backlogController.findAll();
        },
        showNewIteration: function(router) {
          router.transitionTo('root.index.backlog.newIteration', {});
        },
        showScrumBoard: function(router) {
          router.transitionTo('root.index.scrumBoard', {});
        },
        selectCurrentIteration: function(router, event) {
          router.get('backlogController').selectIteration(event.context.get('id'))
        },
        editUserStory: function(router, event) {
          router.transitionTo('root.index.userStories.edit', event.context);
        },
        connectOutlets: function(router, context) {
          router.get('applicationController').connectOutlet({
            viewClass: EdgeAgility.BacklogView,
            controller: router.get('backlogController')
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
            router.transitionTo('root.index.backlog.index');
          },
          connectOutlets: function(router, context) {
            router.get('backlogController').connectOutlet({
              outletName: 'quickBar',
              viewClass: EdgeAgility.NewIterationView,
              controller: router.get('newIterationController')
            });
            router.get('newIterationController').enterNew();
          }
        })
      }),
      projects: Ember.Route.extend({
        route: '/projects',
        edit: Ember.Route.extend({
          route: '/:project_id/edit',
          cancelEdit: function(router) {
            router.transitionTo('root.index.dashboard');
          },
          connectOutlets: function(router, context) {
            var projectsController = router.get('projectsMenuController');
            projectsController.connectOutlet('editProject', context);
            router.get('editProjectController').enterEdit();       
          },
          exit: function(router) {
            router.get('editProjectController').exitEdit();
          }
        }),
        new: Ember.Route.extend({
            route: '/new',
            cancelNew: function(router) {
              router.transitionTo('root.index.dashboard');
            },
            connectOutlets: function(router, context) {
              router.get('projectsMenuController').connectOutlet('newProject');
              router.get('newProjectController').enterNew();
            }
        })
      }),
      userStories:  Ember.Route.extend({
        route: '/user_stories',
        showNewUserStory: function(router) {
          router.transitionTo('root.index.userStories.new', {});
        },
        editUserStory: function(router, event) {
          router.transitionTo('root.index.userStories.edit', event.context);
        },
        destroyUserStory: function(router, event) {
          event.context.deleteRecord();
          EdgeAgility.store.commit();
          router.transitionTo('root.index.userStories.index');
        },
        enter: function (router) {
          console.log("The user_stories sub-state was entered.");
        },
        connectOutlets: function(router, context) {
          //router.get('applicationController').connectOutlet("userStories", EdgeAgility.store.findAll(EdgeAgility.UserStory));
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
              router.transitionTo('root.index.backlog.index');
            },
            connectOutlets: function(router, context) {
              router.get('applicationController').connectOutlet('editUserStory', context);
              router.get('editUserStoryController').enterEdit();       
            },
            exit: function(router) {
              router.get('editUserStoryController').exitEdit();
            }
        }),
        new: Ember.Route.extend({
            route: '/new',
            cancelNew: function(router) {
              router.transitionTo('root.index.userStories.index');
            },
            connectOutlets: function(router, context) {
              router.get('userStoriesController').connectOutlet('newUserStory');
              router.get('newUserStoryController').enterNew();
            }
        })
      })
      
    })
  })
});