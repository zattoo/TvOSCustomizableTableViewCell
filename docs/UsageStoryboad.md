## Using TvOSCustomizableTableViewCell embedded in a xib or storyboard file

Due to the fact that TvOSCustomizableTableViewCell is a subclass of UITableViewCell, the first step is to drag and drop a regular UITableView from the Object library to your view.

![](art/tableObjectLibrary.jpg)

Then change the value of "Custom Class" to "TvOSCustomizableTableViewCell", and the cell type to "Custom" to avoid the default focus behavior.

![](art/cellCustomClass.jpg) ![](art/cellTypeCustom.jpg)

And that's all...

The custom properties can be configured directly on the Storyboard using IBInspectables.

![](art/ibinspectables.png)

