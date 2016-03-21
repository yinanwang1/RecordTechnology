require('UIView,UIColor');
defineClass('JSPatchViewController', {
            genView: function() {
            var tempView = self.ORIGgenView();
            tempView.setBackgroundColor(UIColor.yellowColor());
            
            return tempView;
            },
            });
