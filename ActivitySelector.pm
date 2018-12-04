=head1 NAME

ActivitySelector.pm - Greedy activity selector creates a subset S' which contains the maximum number of non-conflicting activities of
the set S. The solution S' has the property where |S'| <= |S|.

=head1 SYNOPSIS

     ##################                          ##################
     ################## EXAMPLES OF SIMPLE USAGE ##################
     ##################                          ##################
     use ActivitySelctor;
     use Activity;
     use Sorter;
     
     my @activities;
     for (my $i = 0; $i < n; $i++){
          push (@activities, Activity->new(activity => A, startTime = S, endTime => E));
     }
     my $selector = ActivitySelector->new(sorter => $sorter, activities => \@activities);
     my @selected = $selector->select();

=head2 METHODS

=over 12

=item C<new>

I<< new(sorter => $sorter, activities => \@activities) >>

Constructs a new ActivitySelector.

B<selector> is a sorter object which conforms to AbstractSorter.

B<activities> is a list of acitvities which are of type Activity

=item C<select>

I<select()>

Returns an optimal subset of activities.


=back

=head1 DEPENDENCIES

Carp

Activity

Sorter

=head1 AUTHOR

Author Name (Author Email)

=cut

package ActivitySelector;

#------------------------------ Start the module here ------------------------#

use Carp;
use warnings;
use strict;


sub new {
     #constructor method
     #require parameters
     #sorter => $sorter, activities => @activities
     my $class = shift;
     my $self = {@_};
     bless $self, $class;
     #Any local variables
     $self->{DEBUG} = 0;

     return $self;
}

sub select {
     my $self = shift;
     my @sorted = $self->{sorter}->sort(@{$self->{activities}});
     my @selected = ();
     push (@selected, $sorted[0]);
     my $prev = 0;
     for(my $i = 1; $i < @sorted; $i++){
          if ($sorted[$i]->getStartTime() >= $sorted[$prev]->getEndTime()){
               push (@selected,$sorted[$i]);
               $prev = $i;
          }
     }
     return @selected;
}


sub debugOn {
     #changes local variable DEBUG to 1 to enable debug conditionals
     my $self = shift;
     $self->{DEBUG} = 1;
     
}

sub debugOff {
     #changs local variable DEBUG to 0 to dissable debug conditionals
     my $self = shift;
     $self->{DEBUG} = 0;
}

# --- Modules need to return 1 to indicate to the compilier it is successfully loaded
1;
